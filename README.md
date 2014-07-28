spicerack
=========

A general utility cookbook for Chef.  Spicerack provides libraries for advertising and discovering cookbook aspects such as logfiles, services, ports, and directories.  It also provides a mechanism for providing processing "hints" to cookbooks that make automated decisions about configurations. The cookbook borrows from the concepts set forth in the infochimps  silverware cookbook, and I am indebted to them for blazing the trail with regards to aspect based chef development. 

Recipes
---------
## print_attribute_debug
This recipe will look for an array of arrays in `node[:spicerack][:debug][:attributes]` for which to print debug info.  Each inner array should be in the form [:some, :attribute, :here] which would print debug info on node[:some][:attribute][:here].
