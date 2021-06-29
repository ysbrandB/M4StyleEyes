class TypePicker {
  String lastType = "T-Shirt";
  String lastOppositeType = "Long Shirt";

  JSONObject conversions;
  JSONObject opposites;

  TypePicker() {
    JSONObject typeData = loadJSONObject("./JsonFiles/Conversion.JSON");
    conversions = typeData.getJSONObject("conversions");
    opposites = typeData.getJSONObject("opposites");
  }

  void typeDetermination(String primitive) {
    lastType = conversions.getString(primitive);
    lastOppositeType = opposites.getString(lastType);
  }

  String getLastTypeName() {
    return lastType;
  }

  String getLastOppositeTypeName() {
    return lastOppositeType;
  }
}
