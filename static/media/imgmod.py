import os
from PIL import Image

# Define target aspect ratio (16:9)
TARGET_WIDTH = 16
TARGET_HEIGHT = 9

# Get a list of all image files in the current directory
image_files = [f for f in os.listdir('.') if os.path.isfile(f) and f.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp'))]

# Loop over all image files and process each one
for filename in image_files:
    # Open the image
    image = Image.open(filename)

    # Get the most used color in the image
    most_used_color = max(image.getcolors(image.size[0]*image.size[1]), key=lambda x: x[0])[1]

    # Get the current image size and aspect ratio
    current_width, current_height = image.size
    current_aspect_ratio = current_width / current_height

    # Calculate the new width and height based on the target aspect ratio
    new_width = current_height * TARGET_WIDTH // TARGET_HEIGHT
    new_height = current_height

    # Calculate the padding needed on the left and right sides of the image
    padding = (new_width - current_width) // 2

    # Create a new image with the new size and fill it with the most used color
    new_image = Image.new('RGB', (new_width, new_height), color=most_used_color)

    # Paste the original image onto the new image with padding on the left and right sides
    new_image.paste(image, (padding, 0, padding + current_width, current_height))

    # Save the new image with the same filename as the original image
    new_image.save(filename)

print('Done!')
