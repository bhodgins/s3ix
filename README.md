# The S3IX Operating System #

S3IX provides a sophisticated *nix like operating system that breaks away from the idea that everything is a file. Instead, everything (ideally) is a stream.

This works because all files can be reprented as streams. It is almost a drop in replacement for the original idea of a traditional UNIX or UNIX-like operating system.

### Setup ###

Currently S3IX requires a vendor library called middleclass. This library is not provided at the moment, but will be in the future. To install it, simply clone the following directory from github and place the contents in 'lib/vendor/middleclass':

`git clone https://github.com/kikito/middleclass`

After this is settled, you should be able to boot the 'DEFAULT' kernel (located in /boot) by copying the contents to a floppy / disk Drive and booting from your preferred bootloader, or the provided init.lua (NOT YET IMPLEMENTED).

Check regularly for updates on when S3IX becomes naturally bootable.
