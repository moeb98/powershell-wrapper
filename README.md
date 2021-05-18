# powershell-wrapper

This is a powershell script that transforms a given input powershell script
into a batch file for the command line. The advantage is that executing
batch files in Windows e.g. via a double-click on a shortcut is not limited
e.g. by the powershell execution policy and, at least currently, is better
integrated into the operating system. The input powershell script is embedded
into the batch file with the extension ```.cmd``` in which the powershell
script is wrapped by the relevant command line calls to execute the powershell
script from within the batch file

## Usage

The script is called as follows:

```powershell-wrapper.ps1 inputfile.ps1 outputfile.cmd```

The command line argument for the inputfile is required while providing the
output file is optional. In case this is not given, the powershell wrapper
uses the filename of the input file and replaces the extension ```.ps1```
with ```.cmd```.
