# importamos el modulo Tkinter
from tkinter import *
from tkinter.ttk import *

# importamos el metodo strftime que devuelve la hora local
from time import strftime

# creamos una ventan con Tkinter
root = Tk()

# titulo de la ventana
root.title('Reloj-Tarea8-1814035')

#icono del programa
#root.iconbitmap(r'')

#  creamos la funcion hora() para mostrar la hora en un label
def hora():

    # obtenemos la hora local
    datos = strftime('%I:%M:%S %p')

    # pasamos la hora al label
    label.config(text = datos)

    # hacemos un retardo de tiempo de 1 segundo, antes de ejecutar el reloj
    label.after(1000, hora) 

# estilizo m i reloj
label = Label(root,
    font = (
        'Calibri', 80
    ),
    padding = '30',
    background = 'black',
    foreground = 'green'
)

# expando el reloj en el centro de la ventana
label.pack(expand = True)

# llamamos a la funcion hora()
hora()

# con el metodo mainloop() decimos a python que se detenga hasta aqui
# y no ejecute nada mas
mainloop()