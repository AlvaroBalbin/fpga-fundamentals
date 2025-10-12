# Electronic Lock

## Overview
Simple 4 bit electronic lock implemented as a finite state machine. The user can program the password by moving the 8 switches either to 1 or to 0 each two switches represents two bits. Therefore the inputs to the lock range from 0 to 3. The buttons(keys) represent each number 0-3 from right to left. The furthermost button is the clock edge. The display will only turn to **Open** when the user puts the 4 correct digits consecutively, and the LEDs will happen display to him whether he is inputting the *n number* input correctly or not.

Furthermore, the **reset** functionality will bring the user to the first state every time back to **Closed**. Lastly the *8th switch* will display **"EEE"** on the FPGA, this is our own extra easter egg.

[![Electronic Lock demonstration](https://img.youtube.com/vi/Txg3RVC08ts/0.jpg)](https://youtube.com/shorts/Txg3RVC08ts?feature=share)

[![Reset functionality demonstration](https://img.youtube.com/vi/u20EpN3Ar_w/0.jpg)](https://youtube.com/shorts/u20EpN3Ar_w?feature=share)
