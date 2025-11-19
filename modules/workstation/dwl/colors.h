#define COLOR(NAME, hex) \
  static const float NAME[] = { ((hex >> 24) & 0xFF) / 255.0f, \
                                ((hex >> 16) & 0xFF) / 255.0f, \
                                ((hex >> 8) & 0xFF) / 255.0f,  \
                                (hex & 0xFF) / 255.0f };

COLOR(rootcolor,     0x{{colors.surface_dim.default.hex_stripped}}ff)
COLOR(bordercolor,   0x{{colors.outline_variant.default.hex_stripped}}ff)
COLOR(focuscolor,    0x{{colors.primary.default.hex_stripped}}ff)
COLOR(urgentcolor,   0x{{colors.error.default.hex_stripped}}ff)
COLOR(fullscreen_bg, 0x{{colors.surface.default.hex_stripped}}ff)

#undef COLOR
