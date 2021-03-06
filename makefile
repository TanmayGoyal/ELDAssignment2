BIN=blink
OBJS=blink.o
FILE=blink.c
HEX=blink.hex
ELF=blink.elf
PROG=-mmcu=atmega328p
CC=avr-gcc
OBJCOPY=avr-objcopy
CFLAGS=-Os -DF_CPU=16000000UL -mmcu=atmega328p
PORT= "/dev/ttyUSB0"
DUDE=avrdude
FLAGS= -F -V -c arduino -p ATMEGA328P -P
RATE= -b 57600
complete: compile code clean
code: $(HEX)
	$(DUDE) -p atmega328p $(RATE) -P $(PORT) -c arduino -U flash:w:$(BIN)
compile:
	$(CC) $(CFLAGS) -c -o $(OBJS) $(FILE)
	$ $(CC) $(PROG) $(OBJS) -o $(BIN)
	$ $(OBJCOPY) -O ihex -R .eeprom $(BIN) $(HEX)

# install:
# 	$(DUDE) $(FLAGS) $(PORT) $(RATE) -U flash:w:$(HEX)

clean:
	rm -rf $(ELF) $(HEX) $(OBJS)