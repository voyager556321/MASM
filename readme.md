# PIN Code Validation with State Machine (MASM Implementation)

This project implements a **PIN code validation system** written in **MASM** (Microsoft Macro Assembler) for **Intel processors** running **Microsoft Windows**.

## Overview

The program validates a 5-digit PIN code entered by the user. Each position in the PIN has specific constraints (ranges), and the system checks whether these constraints are satisfied for the corresponding positions. If the constraints are met, the PIN is considered valid; otherwise, it's invalid.

## Key Features

- **5-Digit PIN Validation**: The user inputs a PIN consisting of 5 digits.
- **Range-Based Validation**: Each digit in the PIN is associated with a specific range. The system checks if each digit falls within its designated range.
- **State Machine**: The program utilizes a **finite state machine (FSM)** to track the validation process for each digit in the PIN code.

## How It Works

1. **User Input**: The user enters a PIN code consisting of 5 digits.
2. **State Machine Logic**:
   - The program transitions between states as each digit is processed.
   - For every odd-positioned digit (1st, 3rd, 5th), the PIN code is checked against a predefined range.
   - If any digit falls outside its allowed range, the PIN code is declared invalid.
3. **Result**: The program outputs whether the entered PIN code is valid or invalid based on the above checks.

