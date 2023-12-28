#!/bin/sh

read -p "Do you want to install or uninstall? (install/uninstall) " choice

case $choice in
    install|INSTALL)
        read -p "Are you sure you want to install? (yes/no) " install_confirm
        case $install_confirm in
            yes|YES)
                echo "Downloading Klipper Repository"
		git clone https://github.com/K1-Klipper/klipper.git /usr/data/klipper
		mv /usr/share/klipper /usr/share/old.klipper
		ln -s /usr/data/klipper /usr/share/klipper
  		cp /usr/data/printer_data/config/printer.cfg /usr/data/printer_data/configs/printer.bak
		cp /usr/data/printer_data/config/gcode_macro.cfg /usr/data/printer_data/config/gcode_macro.bak
    		sed '/^[bl24c16f]$/,/^$/d' /usr/data/printer_data/config/printer.cfg
      		sed '/^square_corner_max_velocity: 200.0$/d' /usr/data/printer_data/config/printer.cfg
			sed '/\[gcode_macro START_PRINT\]/,/CX_PRINT_DRAW_ONE_LINE/d' /usr/data/printer_data/config/gcode_macro.cfg
			sed 's/CXSAVE_CONFIG/SAVE_CONFIG/g' /usr/data/printer_data/config/gcode_macro.cfg
			file_to_check="/usr/data/printer_data/config/KAMP_settings.cfg"
                if [ -f "$file_to_check" ]; then
                    echo "Found KAMP installing start macro for KAMP"
		    sed '/\[include printer_params.cfg\]$/a\[include start_macro_KAMP.cfg\]' /usr/data/printer_data/config/printer.cfg
                    wget -P /usr/data/printer_data/config/ https://github.com/K1-Klipper/installer_script_k1_and_max/raw/main/start_macro_KAMP.cfg 
                else
                    echo "KAMP not found. Installing normal start macro"
		    sed '/\[include printer_params.cfg\]$/a\[include start_macro.cfg\]' /usr/data/printer_data/config/printer.cfg
                    wget -P /usr/data/printer_data/config/ https://github.com/K1-Klipper/installer_script_k1_and_max/raw/main/start_macro.cfg
                fi
		/etc/init.d/S55klipper_service restart
                ;;
            no|NO)
                echo "Installation cancelled."
                ;;
            *)
                echo "Invalid input. Please enter 'yes' or 'no'."
                ;;
        esac
        ;;
    uninstall|UNINSTALL)
        read -p "Are you sure you want to uninstall? (yes/no) " uninstall_confirm
        case $uninstall_confirm in
            yes|YES)
                echo "Uninstalling..."
                rm /usr/share/klipper
		mv /usr/share/old.klipper /usr/share/klipper
  		mv /usr/data/printer_data/config/printer.bak /usr/data/printer_data/configs/printer.cfg
  		mv /usr/data/printer_data/config/gcode_macro.bak /usr/data/printer_data/configs/gcode_macro.cfg
		/etc/init.d/S55klipper_service restart
		;;
            no|NO)
                echo "Uninstallation cancelled."
                ;;
            *)
                echo "Invalid input. Please enter 'yes' or 'no'."
                ;;
        esac
        ;;
    *)
        echo "Invalid input. Please enter 'install' or 'uninstall'."
        ;;
esac
