# Cinnamon-Layout

Cinnamon-Layout is a utility to switch between different Cinnamon desktop layouts based on pre-defined gschema.override files. Cinnamon-Layout is run for each user wanting to change their desktop layout. The user is then prompted to run `cinnamon-layout-system`, which would change the system default by placing a symlink to the chosen `gschema.override` file in `/usr/share/glib-2.0/schemas`, effectively making it the system default.

There are different branches of Cinnamon-Layout depending on the version of Cinnamon. Check the different branches for the source.

Applets or extensions that are used by different Cinnamon-Layouts that are not part of the core Cinnamon applets or extensions are bundled as part of Cinnamon-Layout to ensure that they will be found.

Cinnamon-Layout can be run at the user level non-interactively from a terminal by supplying a layout such as:

```
cinnamon-layout redmond7
```

Similarly, Cinnamon-Layout-System can be run at the system level (to change system defaults for a new user, for example) non-interactively in this way:

```
cinnamon-layout-system redmond7
```

For customizers, Cinnamon allows customizing the Main App Menu icon and label. Here are examples that could be included in your own `gschema.override` file and added to `/usr/share/glib-2.0/schemas`:
```
[org.cinnamon]
app-menu-icon-name = 'wasta-linux-squircle'
app-menu-label = 'Menu'
```

***NOTE:*** some Cinnamon-Layouts will remove the app-menu-label, but you should still specify an `app-menu-label` in your `gschema.override` file for localization purposes for the layouts that will use a descriptive label for the Application Menu.

***NOTE:*** To use a `gschema.override` file, place it in the `/usr/share/glib-2.0/schemas/` folder and then compile the schemas with the new overrides this way:
```
glib-compile-schemas /usr/share/glib-2.0/schemas/
```
After that, the updated schemas will now be system defaults, so if you reset your gsettings using something like `gsettings reset-recursively org.cinnamon`, or create a new user they will use these settings.
