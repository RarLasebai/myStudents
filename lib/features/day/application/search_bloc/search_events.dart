abstract class SearchEvents {}

class GetSearchResultsEvent implements SearchEvents {
  String name;
  GetSearchResultsEvent(this.name);
}
