import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/image_data.dart';
import 'pixabay_service.dart';

/// A [StateProvider] to hold the current search query.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// A [StateNotifier] that manages the state of the list of images fetched from the Pixabay API.
class ImageNotifier extends StateNotifier<List<ImageData>> {
  /// Creates an instance of [ImageNotifier] with a reference to the [Ref] object.
  /// Fetches initial pages of images.
  ImageNotifier(this.ref) : super([]) {
    fetchInitialImages();
  }

  final Ref ref;

  /// Reference to the provider context.
  int _page = 1;

  /// Tracks the current page of the API pagination.
  bool _isLoading = false;

  /// Prevents multiple simultaneous API calls.

  /// Fetches the initial set of images by loading multiple pages.
  Future<void> fetchInitialImages() async {
    _resetPaginationAndState();

    /// Reset pagination and state to initial values.

    /// Fetch multiple pages initially to populate the gallery.
    for (int i = 0; i < 3; i++) {
      await fetchImages(isLoadMore: true);
    }
  }

  /// Fetches images from the Pixabay API.
  /// [isLoadMore] indicates whether to append new images or replace the current state.
  Future<void> fetchImages({bool isLoadMore = false}) async {
    if (_isLoading) return;

    /// Prevent concurrent fetches.
    _isLoading = true;

    final query = ref.read(searchQueryProvider);

    /// Read the current search query.

    try {
      final newImages =
          await PixabayService().fetchImages(query: query, page: _page);
      state = isLoadMore ? [...state, ...newImages] : newImages;

      /// Update state.
      _page++;

      /// Increment page for next fetch.
    } catch (e) {
      /// Handle error appropriately (consider logging to an error reporting service).
      _handleError(e);
    } finally {
      _isLoading = false;

      /// Reset loading flag.
    }
  }

  /// Resets the state and fetches images from the first page.
  void reset() {
    _resetPaginationAndState();
    fetchInitialImages();
  }

  /// Fetches the next page of images and appends them to the current state.
  void fetchNextPage() {
    fetchImages(isLoadMore: true);
  }

  /// Resets pagination and clears the state.
  void _resetPaginationAndState() {
    _page = 1;
    state = [];
  }

  /// Handles errors gracefully, potentially sending them to a reporting service.
  void _handleError(Object error) {
    // Log or send error to a reporting service
    debugPrint('Error fetching images: $error');
  }
}

/// A [StateNotifierProvider] that provides an instance of [ImageNotifier].
final imageProvider =
    StateNotifierProvider<ImageNotifier, List<ImageData>>((ref) {
  return ImageNotifier(ref);
});
