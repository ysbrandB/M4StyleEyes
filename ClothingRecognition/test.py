from PIL import Image
import cv2

img = cv2.imread('./test.jpg')
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

def quantize_to_palette(image, dither=False):
    image.load()
    palette_data = [
    50, 50, 50,    # black
    110, 110, 110, # dark gray
    170, 170, 170, # light gray
    255, 255, 255, # white

    255, 0, 0,     # red
    166, 66, 46,   # red
    171, 101, 87,  # red
    103, 34, 37,   # red

    186, 20, 81,   # red
    140, 6, 48,    # red
    166, 28, 56,   # red
    122, 5, 21,    # red

    156, 34, 40,   # red
    148, 18, 18,   # red
    255, 135, 10,  # orange
    150, 37, 0,    # orange

    186, 46, 0,    # orange
    207, 83, 0,    # orange
    196, 95, 0,    # orange
    145, 75, 5,    # brown

    97, 36, 16,    # brown
    128, 41, 13,   # brown
    255, 220, 0,   # yellow
    171, 153, 38,  # yellow

    112, 103, 42,  # yellow
    161, 155, 0,   # yellow
    194, 161, 43,  # yellow
    20, 220, 20,   # green

    164, 181, 33,  # green
    127, 143, 3,   # green
    118, 163, 3,   # green
    63, 105, 0,    # green

    64, 130, 26,   # green
    9, 117, 56,    # green
    0, 255, 210,   # turqouise
    9, 117, 81,    # turqouise

    31, 153, 129,  # turqouise
    5, 102, 83,    # turqouise
    35, 173, 171,  # turqouise
    11, 122, 121,  # turqouise

    5, 110, 255,   # blue
    20, 94, 112,   # blue
    0, 123, 153,   # blue
    32, 88, 128,   # blue

    2, 71, 120,    # blue
    40, 86, 184,   # blue
    33, 37, 163,   # blue
    160, 0, 255,   # purple

    50, 30, 130,   # purple
    32, 8, 92,     # purple
    81, 29, 140,   # purple
    95, 15, 186,   # purple

    82, 13, 120,   # purple
    158, 31, 204,  # purple
    255, 0, 210,   # pink
    191, 49, 204,  # pink

    148, 10, 143,  # pink
    179, 48, 174,  # pink
    128, 18, 104,  # pink
    212, 51, 177,  # pink

    163, 21, 106,  # pink
    0, 0, 0,       # filler
    0, 0, 0,       # filler
    0, 0, 0,       # filler
    ] * 4

    palette_image = Image.new('P', (16, 16)) #256 coloroiios
    palette_image.putpalette(palette_data)
    im = image.im.convert("P", 0, palette_image.im)
    return image._new(im)


pil_img = Image.fromarray(img)
pil_img = quantize_to_palette(pil_img, dither=False)
pil_img.show()