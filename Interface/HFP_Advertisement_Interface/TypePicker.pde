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
            put("short_sleeve_top", "Roy donders Juichpak");
            put("long_sleeve_top", "Henkie");
            put("short_sleeve_outwear", "Tuinbroek");
        }};
    }

    void typeDetermination(String primitive) {
        lastType = typeDictionary.get(primitive);
        lastOppositeType = "Pyama"; //Dit moet dus later random uit de lijst van types worden gekozen
    }

    String getLastTypeName() {
        return lastType;
    }

    String getLastOppositeTypeName() {
        return lastOppositeType;
    }
}