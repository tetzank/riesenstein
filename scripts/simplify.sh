#!/bin/bash

# simplifiy svg dump from gimp for easier inclusion

tr -s ' ' <"$1" \
| sed 's@\.[0-9][0-9]@@g;s@ d="M @{{< simplepath >}}\nM@;s@ C @C@;s@" />@\n{{< /simplepath >}}\n@'
