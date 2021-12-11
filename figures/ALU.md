# Entity: ALU 

- **File**: ALU.v
## Diagram

![Diagram](ALU.svg "Diagram")
## Ports

| Port name  | Direction | Type   | Description |
| ---------- | --------- | ------ | ----------- |
| A          | input     | [31:0] |             |
| B          | input     | [31:0] |             |
| ALUControl | input     | [1:0]  |             |
| Result     | output    | [31:0] |             |
| ALUFlags   | output    | [3:0]  |             |
## Signals

| Name  | Type        | Description |
| ----- | ----------- | ----------- |
| AddIn | reg [31:0]  | FullAdder32 |
| Sum   | wire [31:0] |             |
| Cout  | wire        |             |
| Cin   | wire        |             |
| N     | reg         |             |
| Z     | reg         |             |
| C     | reg         |             |
| V     | reg         |             |
## Processes
- Result_Define: ( @(*) )
  - **Type:** always
  - **Description**
  Result 
- Flags_Set: ( @(*) )
  - **Type:** always
  - **Description**
  Flags 
## Instantiations

- fulladder: FullAdder32
