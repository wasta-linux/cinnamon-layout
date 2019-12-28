# Cinnamon-Layout

Cinnamon-Layout is a utility to switch between different Cinnamon desktop layouts based on pre-defined gschema.override files. Cinnamon-Layout is run for each user wanting to change their desktop layout. The user is then prompted to run `cinnamon-layout-system`, which would change the system default by placing a symlink to the chosen `gschema.override` file in `/usr/share/glib-2.0/schemas`, effectively making it the system default.

There are different branches of Cinnamon-Layout depending on the version of Cinnamon. Check the different branches for the source.

The default layout does not depend on any additional Cinnamon applets or extensions. However, other layouts may depend on them. The additional applets or extensions that are used by different Cinnamon-Layouts are bundled as part of Cinnamon-Layout to ensure that they will be found.

Cinnamon-Layout can be run at the user level non-interactively from a terminal by supplying a layout such as:

```
cinnamon-layout redmond7
```

Similarly, Cinnamon-Layout-System can be run at the system level (to change system defaults) non-interactively in this way:

```
cinnamon-layout-system redmond7
```

For customizers, the Cinnamon Main Menu icon has been registered with the Debian update-alternatives system. This means that the menu icon is set to the symlink /usr/share/cinnamon-layout/menu-icon which in turn is set by whatever is registered as the current target. You can register your own icon as an alternative file with this command:

```
update-alternatives --install /usr/share/cinnamon-layout/menu-icon menu-icon \
    /path/to/your/icon.png 100
```

You then need to set menu-icon to your update-alternative selection:

```
update-alternatives --set menu-icon /path/to/your/icon.png
```
