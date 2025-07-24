# Scientific Plotting Guidelines

A comprehensive guide with configuration for creating publication-quality figures in Python (matplotlib) and MATLAB

## Quick Start

### Python (matplotlib)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/plotting_guidelines.git
   cd plotting_guidelines
   ```
   
   **Or download just the `plot_config.py` file**

2. **Install dependencies:**
   ```bash
   pip install matplotlib numpy
   ```

3. **Use in your code:**
   ```python
   import matplotlib.pyplot as plt
   from plot_config import params, contourLevels, colormap, savefig_format
   
   # Apply plot settings
   plt.rcParams.update(params)
   
   # Your plotting code here...
   ```
4. **Follow the example script:**
   - `examples/python_plotting_example.ipynb` 

### MATLAB

- **Follow the example script:**
   - `examples/matlab_plotting_examples.m`
     
##  Plotting Guidelines

### Figure Dimensions
- **4 inches** for single-panel figures (half-page width)
- **8 inches** for multi-panel figures (full-page width)
- Figure size units are in inches by default for matplotlib
- This ensures consistency of font size across different figures. If the figure width is kept constant, the same font size can be used across all figures and would appear similar across the manuscript

### Font Specifications
- **8-10 pt** font size to align with typical journal text sizes
- **LaTeX rendering** enabled when available (with automatic fallback)
- **Computer Modern Serif** is closest to the LaTeX font; other commonly recommended fonts are Arial and Helvetica.
### Color Standards
- **Black** (`'black'`) for ground truth or reference data
- **Primary colors**: Black, Red (`'red'`), and Blue (`'blue'`)

### Contour Plot Standards
- **Colormap**: `'bwr'` (blue-white-red) with white representing zero
- **Levels**: 100+ contour levels for publication quality (default is 20)
- **High DPI**: Save figures with 600+ DPI in raster formats (JPG, PNG)

### Legend Formatting
- Frameless legends: `plt.legend(frameon=False)`

### File Formats
- **Line plots**: PDF, EPS, or SVG (vector graphics preferred)
- **Contour plots**: JPG or PNG with DPI ≥ 600
- **Large PDF/EPS/SVG (vector graphics) files** (>2MB): Convert to high-DPI raster formats (PNG, JPG)

### Best Practices
- **Always save figures** rather than copying from Jupyter notebooks (higher quality)
- Use `bbox_inches='tight'` to remove excessive whitespace
- Set consistent aspect ratios for multi-panel figures


## Installing LaTeX/TeX 

### Check LaTeX Installation
Check if `latex` is installed:
```bash
which latex
```
The output should be similar to:
```bash
$HOME/texlive/2024/bin/x86_64-linux/latex
```

### On Personal Workstations
Install appropriate TeX distribution: https://www.latex-project.org/get/#tex-distributions

### On macOS
Download and install MacTeX.pkg from: https://www.tug.org/mactex/mactex-download.html

Or using Homebrew:
```bash
brew install --cask mactex
```

### On Windows
Download and install [MiKTeX](https://miktex.org/) or [TeX Live](https://tug.org/texlive/).

## 💻 Installing TeX Live on HPC Clusters

For detailed information, visit the [TeX Live Quick Installation Guide](https://tug.org/texlive/quickinstall.html).

### 1. Prepare Working Directory
Navigate to your desired working directory:
```bash
cd ~
```

### 2. Download and Extract Installer
Run the following commands to download and extract the TeX Live installer:
```bash
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf - # note the final `-`
cd install-tl-*
```

### 3. Install TeX Live
Run the installation script (This process can take a few hours; ~2 hours on Stampede):
```bash
perl ./install-tl --no-interaction --paper=letter --texdir=$HOME/texlive/2024
```
Replace `$HOME/texlive/2024` with your desired installation directory.

### 4. Update PATH
To make LaTeX accessible from the command line, update your shell configuration file:
For `~/.bashrc` or `~/.zshrc`:
```bash
export PATH=$HOME/texlive/2024/bin/x86_64-linux:$PATH
```

Reload Configuration:
```bash
source ~/.bashrc
```

### 5. Verify LaTeX Installation
Check if `latex` is accessible:
```bash
which latex
```
The output should be similar to:
```bash
$HOME/texlive/2024/bin/x86_64-linux/latex
```

##  Troubleshooting

- **Path issues**: Manually set the LaTeX PATH in Python
```python
import os
os.environ["PATH"] = f"{os.environ['HOME']}/texlive/2024/bin/x86_64-linux:" + os.environ["PATH"] # use path of installed texlive
```

- **Blurry figures**: Ensure DPI ≥ 600 for raster formats
- **Large file sizes**: Use raster formats (JPG, PNG) with DPI ≥ 600 for complex plots
- **Font inconsistencies**: Verify LaTeX installation and font availability

##  Usage Examples (Python)

### Basic Line Plot
```python
import numpy as np
import matplotlib.pyplot as plt
from plot_config import params, savefig_format

plt.rcParams.update(params)

# Generate data
x = np.linspace(0, 2*np.pi, 200)
y1 = np.sin(x)
y2 = np.cos(x)

# Create figure
fig, ax = plt.subplots(figsize=(4, 3))
ax.plot(x, y1, 'black', label='Truth')
ax.plot(x, y2, 'red', label='Model')

# Formatting
ax.set_xlabel('Time')
ax.set_ylabel('Amplitude')
ax.legend(frameon=False)

# Save
plt.savefig(f'lineplot.svg', bbox_inches='tight')
plt.show()
```

### Multi-Panel Contour Plot
```python
import numpy as np
import matplotlib.pyplot as plt
from plot_config import params, contourLevels, colormap

plt.rcParams.update(params)

# Create data
x = np.linspace(0, 2*np.pi, 128)
y = np.linspace(0, 2*np.pi, 128)
X, Y = np.meshgrid(x, y)
Z1 = np.sin(X) * np.cos(Y)
Z2 = np.sin(2*X) * np.cos(2*Y)

# Create figure
fig, axes = plt.subplots(1, 2, figsize=(8, 4))

# Panel 1
vmax = 0.8 * np.max(np.abs(Z1))
axes[0].contourf(X, Y, Z1, contourLevels, cmap=colormap, 
                 vmin=-vmax, vmax=vmax)
axes[0].set_title(r'$\omega_1$')
axes[0].set_xlabel('X')
axes[0].set_ylabel('Y')

# Panel 2  
vmax = 0.8 * np.max(np.abs(Z2))
axes[1].contourf(X, Y, Z2, contourLevels, cmap=colormap,
                 vmin=-vmax, vmax=vmax)
axes[1].set_title(r'$\omega_2$')
axes[1].set_xlabel('X')

plt.tight_layout()
plt.savefig('contour_plot.jpg', dpi=600, bbox_inches='tight')
plt.show()
```


