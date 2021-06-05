Types = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
'vest', 'sling', 'shorts', 'trousers', 'skirt', 'short_sleeve_dress',
'long_sleeve_dress', 'vest_dress', 'sling_dress']

Colors = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Grey", "White", "Black", "Pink", "Brown"]

for Type in Types:
    print('"' + type + '" : {')
    for Color in Colors:
        print('"' + Color + '" : "",')
    print("}")