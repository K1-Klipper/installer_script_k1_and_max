#!/bin/sh

read -p "Do you want to install or uninstall? (install/uninstall) " choice

case $choice in
    install|INSTALL)
        read -p "Are you sure you want to install? (yes/no) " install_confirm
        case $install_confirm in
            yes|YES)
                echo "Downloading Klipper Repository"
				git clone https://github.com/K1-Klipper/klipper.git /usr/data/klipper
				sed -i 's/PROG=\/\usr\/share\/klippy-env\/bin\/python/PROG=\/\usr\/data\/klippy-env\/bin\/python/g' /etc/init.d/S55klipper_service
				sed -i 's/PY_SCRIPT=\/\usr\/share\/klipper\/klippy\/klippy.py/PY_SCRIPT=\/\usr\/data\/klipper\/klippy\/klippy.py/g' /etc/init.d/S55klipper_service
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
                sed -i 's/PY_SCRIPT=\/\usr\/data\/klipper\/klippy\/klippy.py/PY_SCRIPT=\/\usr\/share\/klipper\/klippy\/klippy.py/g' /etc/init.d/S55KlipperService
				sed -i 's/PROG=\/\usr\/data\/klippy-env\/bin\/python/PROG=\/\usr\/share\/klippy-env\/bin\/python/g' /etc/init.d/S55KlipperService
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
