---
draft: true

author:  Sid Lacy
title: "Test Post"
description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida facilisis rhoncus."
tags: ["test", "tags", "content"]
date: 2022-11-15
lastmod: 2022-11-16

cover:
    path: "https://swlacy.com/media/playing-with-cobalt-strike-2-cover.jpg"
    alt: "Description"
    caption: "Name (Publisher, YYYY)"

hide:
    meta: false
    contents: false
    footnote: false
---



Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida facilisis rhoncus. Nunc ultrices felis vitae lacus pulvinar, sit amet ullamcorper sem varius. Donec rhoncus sollicitudin tellus a aliquam. Proin fermentum nulla sollicitudin felis molestie, quis convallis lacus iaculis. Quisque ac odio id nisl consequat convallis quis in est. Nullam at nisl non neque iaculis lacinia. Donec ex purus, laoreet a ligula sit amet, suscipit lobortis leo.

## H2 Heading

Maecenas fringilla ex in lectus consectetur, at vehicula velit tempor. Etiam congue pharetra efficitur. Fusce scelerisque erat erat, a sagittis ligula feugiat ultrices. Integer mauris velit, dapibus ut dolor nec, tristique scelerisque dui. Praesent lacinia pharetra dui, nec aliquam enim efficitur vitae. Pellentesque sollicitudin, erat et finibus blandit, diam nisi dictum lorem, sed dignissim purus eros vitae purus. Nunc eu nisl eu velit placerat finibus. Nulla facilisi. Donec ut varius odio. Nullam semper erat elit, nec posuere felis lacinia vitae. Duis sodales a nulla quis tempor. In id facilisis arcu.

### H3 Heading

Nulla maximus tempus ex sit amet pulvinar. Cras volutpat risus rutrum, posuere massa pellentesque, auctor lacus. Vivamus in posuere nisl. Curabitur ut nunc eget elit tincidunt lacinia ac eget est. Aenean consectetur mauris a leo tristique, et tempor libero consequat. Mauris vel feugiat quam. Maecenas molestie velit sapien, quis eleifend neque pretium non.

Aenean felis nisi, malesuada sed auctor nec, volutpat sit amet felis. Donec ut risus pulvinar, `some inline code here` suscipit lacus at, commodo est. Curabitur accumsan neque quis nulla egestas condimentum. Integer at ipsum lacinia, ultrices nibh quis, consequat nisi. In posuere lorem nec enim eleifend pellentesque. Proin placerat mi eget dui dignissim, et sodales dolor convallis. Mauris molestie nunc libero, eu tristique velit convallis id.

### H3 Heading that is very long test test test test

Sed molestie nisi ac ligula sollicitudin vehicula. Nulla in bibendum dui. Pellentesque vel ultricies sapien. Nunc bibendum efficitur mauris sit amet laoreet. Curabitur ut augue id tellus dignissim rutrum. Nam commodo neque sit amet dolor ultricies feugiat. Curabitur id quam ipsum. Nullam nec enim ipsum. Aenean pharetra dignissim tempus. Pellentesque faucibus magna et velit luctus, ac dignissim felis tempus. Vestibulum nulla orci, viverra et laoreet in, blandit quis nibh.

```python
#!/usr/bin/env python3

import binascii

xorPat = int("01010101", 2)

with open('output.txt', 'r') as file:
    output = file.read().replace('\n', '')

for bit in range(0, len(output), 8):
    byte = int(output[bit:bit + 8], 2)
    flag = byte ^ xorPat

    print(flag.to_bytes((flag.bit_length() + 7) // 8, 'big').decode(), end = ''); print(flag.to_bytes((flag.bit_length() + 7) // 8, 'big').decode(), end = '')

print()
```

Aliquam erat volutpat. Vestibulum dictum rutrum condimentum. Aenean vitae feugiat lorem. Nam rutrum risus et orci maximus, et tristique purus maximus. Nullam finibus neque eu massa vestibulum, in bibendum tortor cursus. Vestibulum justo elit, malesuada vitae ante at, euismod feugiat nibh. Mauris non magna pretium, faucibus velit id, commodo eros. Sed commodo mi non libero consectetur, quis tincidunt mi aliquet. Sed non rutrum neque, id sagittis nibh.

## H2 Heading

Vivamus dignissim commodo dolor, eget suscipit leo mattis sed. Etiam sed commodo justo. Proin blandit, dui eget euismod gravida, neque metus tempor elit, ut sagittis ex tortor a lorem. Vestibulum hendrerit non odio tincidunt ultricies. Suspendisse fermentum nunc erat, quis mattis risus cursus et. Proin in dui mi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam tempus, nulla eu sagittis pulvinar, felis mi molestie tortor, sed cursus diam erat vel dolor. Etiam pretium, lectus id scelerisque bibendum, tellus tellus molestie ipsum, ac posuere velit ante eget leo. Maecenas accumsan dolor vel dictum consequat. Suspendisse malesuada erat eget eros finibus, non aliquam mauris porta.

Maecenas interdum diam in elit efficitur pellentesque. Nam porta erat ac ante interdum blandit. Integer ullamcorper ex et tempus bibendum. Sed faucibus lacus massa, ultricies pretium ex dapibus a. Duis tempus dapibus metus ut molestie. Maecenas rutrum leo sed finibus vestibulum. Donec malesuada sapien eget faucibus congue. Morbi eget odio ultricies, fermentum diam nec, tincidunt tortor. Interdum et malesuada fames ac ante ipsum primis in faucibus. 
