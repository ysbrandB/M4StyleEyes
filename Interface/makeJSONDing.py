types = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
'vest', 'sling', 'shorts', 'trousers', 'skirt', 'short_sleeve_dress',
'long_sleeve_dress', 'vest_dress', 'sling_dress']

kleuren = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Grey", "White", "Black", "Pink", "Brown"]

for type in types:
    print('"' + type + '" : {')
    for kleur in kleuren:
        print('"' + kleur + '" : "",')
    print("}")