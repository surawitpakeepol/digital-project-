# 🦖 Dino Runner on FPGA (VGA)

A simple Dino Runner game implemented on FPGA using VGA output.  
This project demonstrates digital design concepts including VGA signal generation, game logic, and real-time rendering.

---

## 🎯 Project Overview

This project is a hardware-based implementation of the classic **Dino Runner Game** using an FPGA board.

- Display via **VGA**
- Written in **Verilog / VHDL**
- Real-time rendering using pixel scanning
- Basic game mechanics: jump, obstacle, score

---

## 🧠 Key Concepts

- VGA Signal Timing (HSYNC / VSYNC)
- Pixel-based Rendering
- Finite State Machine (FSM)
- Game Loop in Hardware
- Clock Division

---

## ⚙️ Hardware Requirements

- FPGA Board (e.g. Basys 3 / Nexys / etc.)
- VGA Monitor
- Push Buttons (for jump / start)
- Resistors for VGA (e.g. 330Ω for RGB)

---

## 🖥️ VGA Configuration

| Parameter     | Value        |
|--------------|-------------|
| Resolution   | 640 x 480   |
| Refresh Rate | 60 Hz       |
| Pixel Clock  | 25 MHz      |

---

## 🎮 Game Features

- 🦖 Dino character (jumping)
- 🌵 Obstacles (moving)
- 🧮 Score system
- 💀 Collision detection
- 🔁 Restart system

---

## 🗂️ Project Structure

```
digital-project/
│── top.v / top.vhdl        # Main module
│── vga_controller.v        # VGA timing generator
│── game_logic.v            # Game mechanics
│── game_graphics.v         # Rendering objects
│── clock_divider.v         # Clock generation
│── constraints.xdc/.ucf    # Pin configuration
```

---

## 🚀 Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/surawitpakeepol/digital-project.git
cd digital-project
```

### 2. Open in FPGA Tool
- Xilinx Vivado / ISE

### 3. Synthesize & Program
- Generate bitstream
- Upload to FPGA board

---

## 🎮 Controls

| Button | Function |
|--------|--------|
| BTN1   | Jump   |
| BTN2   | Start  |

---

## ⚠️ Known Issues

- Score display may glitch if clock mismatch
- Timing must be strictly aligned with VGA clock
- Incorrect HSYNC/VSYNC causes display distortion

---

## 📚 Learning Outcomes

This project helps understand:

- Digital System Design
- Real-time graphics without GPU
- Hardware-level game development
- Timing-critical systems

---

## 👨‍💻 Author

- **Surawit Phakeepon**
- Computer Science @ KMUTT

---

## 📌 Future Improvements

- Add sound (PWM audio)
- Improve graphics (sprite system)
- Add multiple obstacles
- Add difficulty scaling

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!
