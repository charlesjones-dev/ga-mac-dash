#!/usr/bin/env python3
"""
Generate app icon with GA text on blue background
"""
from PIL import Image, ImageDraw, ImageFont
import os

# Icon sizes needed for macOS
sizes = [16, 32, 64, 128, 256, 512, 1024]

# Blue background color
BLUE = (0, 122, 255)  # iOS/macOS blue
WHITE = (255, 255, 255)

def create_icon(size):
    """Create an icon of the given size"""
    # Create image with blue background
    img = Image.new('RGB', (size, size), BLUE)
    draw = ImageDraw.Draw(img)

    # Calculate font size (roughly 50% of icon size)
    font_size = int(size * 0.5)

    # Try to use a system font, fallback to default if not available
    try:
        # Use San Francisco font on macOS
        font = ImageFont.truetype('/System/Library/Fonts/Supplemental/Arial Bold.ttf', font_size)
    except:
        try:
            font = ImageFont.truetype('/System/Library/Fonts/SFNS.ttf', font_size)
        except:
            # Fallback to default font
            font = ImageFont.load_default()

    # Get text bounding box for centering
    text = "GA"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]

    # Calculate position to center text
    x = (size - text_width) // 2 - bbox[0]
    y = (size - text_height) // 2 - bbox[1]

    # Draw text
    draw.text((x, y), text, fill=WHITE, font=font)

    return img

def main():
    # Output directory
    iconset_dir = "GA Mac Dashboard/Assets.xcassets/AppIcon.appiconset"

    print("Generating app icons...")

    for size in sizes:
        # 1x version
        img = create_icon(size)
        filename = f"icon_{size}x{size}.png"
        filepath = os.path.join(iconset_dir, filename)
        img.save(filepath, 'PNG')
        print(f"Created {filename}")

        # 2x version (double size)
        if size <= 512:  # Don't create 2x for 1024
            img_2x = create_icon(size * 2)
            filename_2x = f"icon_{size}x{size}@2x.png"
            filepath_2x = os.path.join(iconset_dir, filename_2x)
            img_2x.save(filepath_2x, 'PNG')
            print(f"Created {filename_2x}")

    print("\nApp icons generated successfully!")
    print("Updating Contents.json...")

    # Update Contents.json
    contents_json = """{
  "images" : [
    {
      "filename" : "icon_16x16.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "16x16"
    },
    {
      "filename" : "icon_16x16@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "16x16"
    },
    {
      "filename" : "icon_32x32.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "32x32"
    },
    {
      "filename" : "icon_32x32@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "32x32"
    },
    {
      "filename" : "icon_128x128.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "128x128"
    },
    {
      "filename" : "icon_128x128@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "128x128"
    },
    {
      "filename" : "icon_256x256.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "256x256"
    },
    {
      "filename" : "icon_256x256@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "256x256"
    },
    {
      "filename" : "icon_512x512.png",
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "512x512"
    },
    {
      "filename" : "icon_512x512@2x.png",
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "512x512"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}"""

    contents_path = os.path.join(iconset_dir, "Contents.json")
    with open(contents_path, 'w') as f:
        f.write(contents_json)

    print("Contents.json updated!")
    print("\nDone! The app icon has been generated.")

if __name__ == "__main__":
    main()
