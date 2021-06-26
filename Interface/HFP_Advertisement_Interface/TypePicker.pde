class TypePicker {
    String lastType = "T-Shirt";
    String lastOppositeType = "Long Shirt";

    JSONObject conversions;
    JSONObject opposites;

    TypePicker() {
        JSONObject typeData = loadJSONObject("./JsonFiles/Types.JSON");
        conversions = typeData.getJSONObject("conversions");
        opposites = typeData.getJSONObject("opposites");
    }

    void typeDetermination(String primitive) {
        lastType = conversions.getString(primitive);
        lastOppositeType = conversions.getString(lastType);
    }

    String getLastTypeName() {
        return lastType;
    }

    String getLastOppositeTypeName() {
        return lastOppositeType;
    }
}
