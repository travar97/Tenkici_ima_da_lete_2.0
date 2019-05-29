from PIL import Image
from sys import argv

sprite_name = argv[1] if len(argv) > 1 else input("file name: ")
sprite = Image.open(sprite_name)


def chunks(list, chunk_size):
    for i in range(0, len(list), chunk_size):
        yield list[i: (chunk_size + i)]


def colorMap(rgb):
    rgb = (rgb[2], rgb[1], rgb[0])
    pallette = {
        # Redosled boja: B G R
        (0x00, 0x00, 0x00): "00",
        (0x80, 0x80, 0x00): "01",
        (0xFF, 0xFF, 0xFF): "02",
        (0x00, 0x00, 0x80): "03",
        (0x80, 0x60, 0x60): "04",
        (0x00, 0x40, 0xA0): "05",
        (0x00, 0x60, 0x00): "06",
        (0x00, 0x40, 0x00): "07",
        (0x00, 0xE0, 0x80): "08",
        (0xA4, 0xA0, 0xA0): "09",
        (0xC0, 0x40, 0x40): "0A",  # Znaci ovo je boja #4040c0
        (0xF0, 0xCA, 0xA6): "0B",
        (0x40, 0x40, 0x00): "0C",
        (0x80, 0x00, 0x60): "0D",
        (0x40, 0x40, 0xC0): "0E",
        (0x80, 0xE0, 0xE0): "0F",
        (0x40, 0xA0, 0xE0): "10",
        (0x00, 0x60, 0x60): "11",
        (0x00, 0x00, 0x00): "12",
        (0x00, 0x00, 0x00): "13",
        (0x00, 0x00, 0x00): "14",
        (0x00, 0x00, 0x00): "15",
        (0x00, 0x00, 0x00): "16",
        (0x00, 0x00, 0x00): "17",
        (0x00, 0x00, 0x00): "18",
        (0x00, 0x00, 0x00): "19",
        (0x00, 0x00, 0x00): "1A",
        (0x00, 0x00, 0x00): "1B",
        (0x00, 0x00, 0x00): "1C",
        (0x00, 0x00, 0x00): "1D",
        (0x00, 0x00, 0x00): "1E",
        (0x00, 0x00, 0x00): "1F",
    }
    if rgb in pallette:
        return pallette[rgb]
    else:
        return "??"  # Nepostojeca boja - mora biti nesto iz palete


num = int(input("Pocetni indeks: "))
output = []
for y in range(sprite.size[1]):
    row = [sprite.getpixel((x, y)) for x in range(sprite.size[0])]
    row = [colorMap(rgb) for rgb in row]
    for line in ["".join(chunk) for chunk in chunks(row, 4)]:
        print(repr(num) + " => x\"" + line + "\",",)
        num += 1