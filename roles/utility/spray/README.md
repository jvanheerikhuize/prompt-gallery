# S.P.R.A.Y. — Stencil Processor and Rapid Assembly Yielder

> **Version:** 2.0 | **Category:** Utility

---

## Overview

S.P.R.A.Y. converts stencil images into clean, print-ready black-and-white PNG files. It analyses the input image, identifies cut regions and material regions, detects floating islands (pieces that would fall out), inserts structural bridges, and outputs a binary stencil image that can be traced to SVG using standard tools (potrace, Inkscape, Illustrator).

All image processing is performed via **code execution** (Python + Pillow), ensuring precision and reproducibility. The output is strictly two-tone — every pixel is pure black (material) or pure white (cut-out) — optimised for artifact-free vector conversion.

**Key capabilities:**
- Automatic island detection and bridge insertion
- Structural integrity guarantee (ONE_PIECE constraint)
- Configurable threshold, bridge density, output size, and DPI
- Multi-layer stencil sets (2-4 colours) with registration marks
- Iterative refinement of bridge placement

---

## Quick Start

1. Open the [`prompt.md`](prompt.md) file and copy the content of the code block.
2. Start a **fresh conversation** in any LLM that supports **code execution** (Claude with tools, ChatGPT with Code Interpreter, Gemini, etc.).
3. Paste and send. S.P.R.A.Y. introduces itself and guides you through the process.
4. Upload a stencil image. S.P.R.A.Y. processes it and returns a black-and-white PNG.

Alternatively, inject as a `system` message in any API or agent framework with code execution support.

---

## Parameters

All parameters are optional — include them as keywords alongside your image.

| Parameter       | Options                             | Default    |
|-----------------|-------------------------------------|------------|
| Threshold       | `auto`, `light`, `medium`, `heavy`  | `auto`     |
| Bridge density  | `minimal`, `standard`, `reinforced` | `standard` |
| Output size     | `A4`, `A3`, or `WxH` in mm          | `A4`       |
| Resolution      | `dpi: N`                            | `dpi: 300` |
| Bridge width    | `bridge width: Xmm`                | `2mm`      |
| Frame width     | `frame width: Xmm`                 | `5mm`      |
| Multi-layer     | `layers: N` (2-4)                   | off        |

---

## Usage Examples

### 1 — Simple single-layer stencil

```
[attach image of a stencil design]
```

S.P.R.A.Y. analyses the image, detects islands, inserts bridges, and outputs a black-and-white PNG with default settings (auto threshold, standard bridges, A4 at 300 DPI).

---

### 2 — High-contrast stencil with minimal bridges

```
[attach image]
heavy minimal 300x400 dpi: 600
```

Heavy threshold for maximum contrast, minimal bridges for clean visual lines, custom output size of 300x400mm at 600 DPI for ultra-clean SVG tracing.

---

### 3 — Multi-layer colour stencil

```
[attach image of a multi-colour design]
layers: 3 A3 reinforced
```

S.P.R.A.Y. separates the design into 3 colour layers, each structurally sound, with registration marks for alignment. Reinforced bridges for durability. Output sized to A3.

---

### 4 — Iteration after initial output

```
Move the bridge on the left eye further down — it cuts through the pupil.
```

S.P.R.A.Y. adjusts bridge placement and re-emits the updated PNG. No need to re-upload the image.

---

## Converting Output to SVG

The output PNG is designed for clean conversion to SVG. Recommended methods:

**Inkscape (GUI):**
1. Open the PNG in Inkscape
2. Select the image, then Path > Trace Bitmap
3. Use Brightness Threshold at 0.5 (the image is already pure black and white)
4. Click OK — the vector paths are your stencil

**potrace (command line):**
```bash
# Convert PNG to PBM first, then trace
convert stencil.png stencil.pbm
potrace -s stencil.pbm -o stencil.svg
```

**Adobe Illustrator:**
1. Place the PNG, then Image Trace
2. Use the Black and White preset
3. Expand the trace to get editable paths

---

## Requirements

S.P.R.A.Y. requires an LLM environment with **code execution** support:

- **Claude** with tool use / computer use
- **ChatGPT** with Code Interpreter
- **Gemini** with code execution
- Any agent framework with Python + Pillow access

The following Python libraries are used:
- `PIL` / `Pillow` (image processing)
- `NumPy` (array operations, connected component analysis)
- `scipy.ndimage` (optional, for labelling and distance transforms)
- `OpenCV` / `cv2` (optional, for morphological operations)

---

## API / Agent Framework

```python
import anthropic, pathlib, base64

role_prompt = pathlib.Path("roles/utility/spray/prompt.md").read_text()

# Read a stencil image
image_data = base64.standard_b64encode(
    pathlib.Path("my-stencil.png").read_bytes()
).decode("utf-8")

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{
        "role": "user",
        "content": [
            {
                "type": "image",
                "source": {
                    "type": "base64",
                    "media_type": "image/png",
                    "data": image_data,
                },
            },
            {
                "type": "text",
                "text": "heavy minimal A3 dpi: 600",
            },
        ],
    }],
)
```

---

## Output Structure

Each successful processing run produces four output blocks:

1. **STENCIL ANALYSIS** — region counts, island detection, threshold applied, dimensions
2. **BRIDGE PLACEMENT** — bridge count, density, width, placement rationale per bridge, structural verification
3. **STENCIL IMAGE** — the black-and-white PNG with conversion tips
4. **PRINT NOTES** — material recommendations, layer height, minimum feature sizes, handling notes

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt (v2.0) |
