# SPARK_PDI_Demo

IMPORTANT: Please note that this project exists as part of a blog entry,
article, or other similar material by AdaCore. It is provided for
convenient access to the software described therein. As such, it is not
updated regularly and may, over time, become inconsistent with the
latest versions of any tools and libraries it utilizes (for example, the
Ada Drivers Library).

This demo project presents how SPARK language can be used to implement
Parameter Data Items for avionics software subject to DO-178
certification. This demo was created in support of a presentation on the _Use
of SPARK to implement Parameter Data Items_ by Frédéric Pothon (ACG-Solutions)
and Yannick Moy (AdaCore) at [Certification Together International
Conference](http://www.certification-together.com), March 21-23, Toulouse,
France.

IMPORTANT: Please note that this project exists as part of a blog entry,
article, or other similar material by AdaCore. It is provided for
convenient access to the software described therein. As such, it is not
updated regularly and may, over time, become inconsistent with the
latest versions of any tools and libraries it utilizes.

## What PDI are

Parameter Data Item (PDI) is the generic term used in DO-178C/ED-12C to address
all kinds of configuration files. The PDI concept is used to define
corresponding objectives and activities to be performed. One of the main
objectives is the verification on the PDI file that the _form of data [that] is
directly usable by the processing unit of the target computer_. The direct
verification of the binary representation is difficult to achieve. Usually, a
mix of textual and XML formalism is used for PDI development, and verification
is done with a combination of analysis and review on the XML file together with
qualified tools.

## Why use SPARK for defining PDI

A most efficient approach is to use a high-level description of the PDI as main
source for both their verification and generation of the binary file. Based on
experiments performed in the scope of [CAP2018
project](http://cap2018.minalogic.net/), we claim benefits for using SPARK as
this high-level description language. SPARK is a formal subset of the Ada
programming language. Types in SPARK provide a convenient way to define the PDI
_structure and attributes_. Constraints on PDI can be expressed as
specifications in the SPARK language: preferably type predicates for
constraints on a set of PDI grouped in the same variable, or arbitrary
assertions for more general constraints. Specific values of PDI can be provided
in a separate SPARK file that defines values of these types. Verification that
these specific values respect the constraints on PDI is performed by compiling
this file into an executable with checks, and executing it once. Generation of
the binary PDI file can be performed by a simple qualified tool.

## Example

The code in this project provides an example of PDI file, and how SPARK can be
used for expressing the PDI, verifying them, and generating the binary PDI
file.

* `pdi.ads` - definition of various kinds of PDI
* `pdi.adb` - definition of the procedures to verify, output and load the PDI
* `define_pdi.adb` - definition of specify values of PDI, generation of the
  binary PDI file, and verifications of consistency
* `print_pdi.adb` - example of application that loads the binary PDI file and
  simply prints the values of PDI on the standard output

A Makefile is given for Unix platforms (Linux, Mac), just type `make demo` to
run it. It requires that you have installed GNAT, the Ada and SPARK compiler,
on your machine. This can be done either using your package manager, of by
downloading and installing [the version of GNAT distributed by
AdaCore](libre.adacore.com).
