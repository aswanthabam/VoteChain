import 'package:flutter/material.dart';

class Pagination extends PaginationContext {
  Pagination({List<Page>? pages}) {
    if (pages != null) {
      for (var element in pages) {
        pageCount++;
        this.pages[pageCount] = element;
      }
    }
  }

  Widget get widget {
    if (currentIndex == 0) {
      if (pageCount > 0) {
        currentIndex++;
        return widget;
      } else {
        return const Placeholder();
      }
    } else {
      return pages[currentIndex]!.buildPage(this);
    }
  }

  void buildAll({bool rebuild = false}) {
    for (Page page in pages.values) {
      if (rebuild) {
        page.rebuild(this);
      } else {
        page.buildPage(this);
      }
    }
  }

  Widget? goto({required int index, bool rebuild = false}) {
    if (pages.containsKey(index)) {
      currentIndex = index;
      if (rebuild) {
        return pages[currentIndex]!.rebuild(this);
      } else {
        return pages[currentIndex]!.buildPage(this);
      }
    } else {
      return null;
    }
  }

  Widget? next({bool rebuild = false}) {
    if (currentIndex + 1 <= pageCount) {
      currentIndex++;
      if (rebuild) {
        return pages[currentIndex]!.rebuild(this);
      } else {
        return pages[currentIndex]!.buildPage(this);
      }
    } else {
      return null;
    }
  }

  Widget? prev({bool rebuild = false}) {
    if (currentIndex - 1 > 0) {
      currentIndex--;
      if (rebuild) {
        return pages[currentIndex]!.rebuild(this);
      } else {
        return pages[currentIndex]!.buildPage(this);
      }
    } else {
      return null;
    }
  }

  bool removePage(int index) {
    if (pages.containsKey(index)) {
      for (var i = index; i < pageCount; i++) {
        pages[i] = pages[i + 1]!;
      }
      pageCount--;
      return true;
    } else {
      return false;
    }
  }

  bool replacePage(Page page, int index) {
    if (pages.containsKey(index)) {
      for (var i = pageCount; i >= index; i++) {
        pages[i + 1] = pages[i]!;
      }
      pages[index] = page;
      return true;
    } else {
      return false;
    }
  }

  void appendPage(Page page) {
    pageCount++;
    pages[pageCount] = page;
  }

  bool hasNext() {
    return currentIndex + 1 <= pageCount;
  }

  bool hasPrev() {
    return currentIndex - 1 > 0;
  }
}

class PaginationContext {
  Map<int, Page> pages = {};
  int pageCount = 0;
  int currentIndex = 0;
}

abstract class Page extends PageState {
  Widget? widget;
  Widget build(PaginationContext state);
  Widget buildPage(PaginationContext state) {
    if (widget != null) {
      return widget!;
    } else {
      widget = build(state);
      return widget!;
    }
  }

  Widget rebuild(PaginationContext state) {
    widget = build(state);
    return widget!;
  }
}

class PageState {
  final Map<String, dynamic> __state = {};
  void Function(void Function())? stateFunction;
  bool widgetBinded = false;

  T? getState<T>(String key) {
    if (__state.containsKey(key)) {
      return __state[key];
    } else {
      return null;
    }
  }

  void setState<T>(String key, T value) {
    if (stateFunction != null) {
      stateFunction!(() {
        __state[key] = value;
      });
    } else {
      print("Paginator : Widget Not Binded to the page");
      __state[key] = value;
    }
  }

  void bindWidgetState(void Function(void Function()) binder) {
    stateFunction = binder;
    widgetBinded = true;
  }
}

class SampleWidget extends Page {
  @override
  Widget build(PaginationContext state) {
    return Text("Page ${state.currentIndex}");
  }
}
