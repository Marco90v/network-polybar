# network-polybar

## English

### Description
Polybar network upload and download speed.

This script shows the Internet Upload and Download speed using an infinite loop, it retrieves the active interface, which can be ethernet or wifi.

Likewise, if there is no Internet connection the result shown will be offline and if there is no interface connected, it will show Disconnected.

### Use
```git
git clone https://github.com/Marco90v/network-polybar.git
```

Place in the path of your polybar theme, for this example it will be: ```~/.config/polybar/hack/scripts```

### Configuration (Polybar)
```ini
[module/network]
type = custom/script
exec = ~/.config/polybar/hack/scripts/network.sh
content = "%output%"
tail=true
```

### Preview
![speed-network](https://github.com/Marco90v/network-polybar/blob/main/2023-01-27_17-32.png)

---

## Español


### Descripción
Velocidad de carga y descarga de la red en la polybar.

Este script muestra la velocidad de Carga y Descarga de Internet haciendo uso de un bucle infinito, para ello recupera la interfaz activa, que puede ser ethernet o wifi.

Así mismo, si no hay conexión a Internet el resultado mostrado sera offline y si no existe ninguna interfaz conectada, mostrara Desconectado.

### Uso
```git
git clone https://github.com/Marco90v/network-polybar.git
```

Coloque en la ruta de su tema de polybar, para este ejemplo sera: ```~/.config/polybar/hack/scripts```

### Configuración (Polybar)
```ini
[module/network]
type = custom/script
exec = ~/.config/polybar/hack/scripts/network.sh
content = "%output%"
tail=true
```

### Vista Previa
![speed-network](https://github.com/Marco90v/network-polybar/blob/main/2023-01-27_17-32.png)
