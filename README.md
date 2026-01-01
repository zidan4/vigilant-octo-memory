# vigilant-octo-memory

For a more advanced version of the currency converter in x86-64 NASM Assembly, let's add:
✅ User input for amount
✅ User selection for conversion currency
✅ Floating point arithmetic (FPU - x87)
✅ Formatted output (two decimal places)

📌 Features:
The user enters an amount in USD.
The user selects a currency (EUR, GBP, JPY, INR, etc.).
The program converts USD to the selected currency.
Displays the formatted result.
🔧 Setup
Since NASM doesn't handle floating-point directly, we use:
✔ x87 FPU for floating-point arithmetic.
✔ printf (from libc) for formatted output.

📂 Full Assembly Code (NASM - x86-64, Linux)
