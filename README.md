# BestFX: The Ultimate Collection of Simulink Blocks and MATLAB Scripts

**BestFX** is a comprehensive toolbox that contains carefully curated best practice guidelines for MATLAB and Simulink. This collection combines powerful Simulink blocks and efficient MATLAB scripts to assist you in developing and optimizing your models.

## Features

- 🛠️ **Easy Integration**: Plug-and-play compatibility with your existing projects.
- 🚀 **Rich Block Library**: Includes blocks such as:
  - **Counter Timer Unit**: Counter unit which counts in different ways. Two counting modes are available (counter/timer), each optionally with the option bidirectional or free-running.
  - **Debounce Unit**: Debouncing unit that suppresses fast changes of the input signal (u) in various ways. Three modes are available (holding element, switch-on delay and switch-off delay).
  - **Flip-Flop**: Bistable flip-flop without restricted combination (forbidden state). Set or reset condition is dominant as soon as both inputs are set. Two flip-flop modes are available.
  - **Discrete Filter**: Digital discrete signal filter. Two modes are available (lowpass/highpass).
  - **Rename**: Renaming of the incoming signal. Other signal properties such as data type and dimension remain unchanged.
  - **Overwrite**: Overwrite the incoming signal value. Other signal properties like data type and dimension remain unchanged.
  - **Design Block**: Colors ports and blocks for better readability and visual organization in your models.
  - ...as well as other helpful blocks.
- 🖱️ **Simulink Context Menu Extension**: Easily align ports or change the size of selected Simulink blocks using a to **BestFX** context menu entry. Choose from various preset heights, widths, or combined sizes directly in the Simulink interface for fast model editing.
## Getting Started

### Option 1: Install via Toolbox Installer

1. Install the toolbox file `Simulink.Library.me.BestFX.mltbx`. To install a MathWorks toolbox (.mltbx file) in MATLAB, you can either use the Add-On Explorer or manually install it by double-clicking the file.
2. The BestFX library will be added to your MATLAB and Simulink environment. Any required dependencies will be installed automatically.

### Option 2: Manual Installation

⚠️ No dependencies should be required. However, if any are needed, they will not be installed automatically during manual installation.

1. **Clone the repository:**
   ```powershell
   git clone https://github.com/tsf-solution/bestfx-toolbox.git
   ```
2. **Add the library to your MATLAB path:**
   ```matlab
   addpath('<path_to_BestFX>')
   ```
3. **Open Simulink and start using the blocks:**
   - Navigate to the BestFX library in Simulink.
   - Drag and drop blocks into your model.

## Documentation

- Each block and script includes detailed documentation and usage examples.

## License

This project is licensed under the MIT License.

## Contact

For questions or support, open an issue or contact the maintainer tsf-solution.

