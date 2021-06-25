import java.util.Map;
import java.util.HashMap;

class TypePicker {
    Map<String, String> typeDictionary;
    String lastType = "Tuinbroek";
    String lastOppositeType = "Zwembroek";
    
    TypePicker() {
        //THIS IS A TEMPORARY SOLUTION AND SHOULD BE REPLACED BY THE VALUES FROM THE JSON DATABASE
        typeDictionary = new HashMap<String, String>()
        {{
            put("short_sleeve_top", "T-Shirt");
            put("long_sleeve_top", "Sweater");
            put("short_sleeve_outwear", "Tuinbroek");
            put("long_sleeve_outwear", "Jacket");
            put("vest", "Tanktop");
        }};
    }

    void typeDetermination(String primitive) {
        //lastType = typeDictionary.get(primitive);
        lastType = "short_sleeve_top";
        lastOppositeType = "long_sleeve_outwear"; //Dit moet dus later random uit de lijst van types worden gekozen
    }

    String getLastTypeName() {
        return lastType;
    }

    String getLastOppositeTypeName() {
        return lastOppositeType;
    }
}
