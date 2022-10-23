$array = Array.new(6){Array.new(7)}
$columnas_llenas = [false,false,false,false,false,false,false]
$usuarioX = true
$usuarioY = false
$juego_terminado = false

def llenar_columna(pos_columna)
  longitud = $array.length-1
  ficha_puesta = false

  while !ficha_puesta && longitud >= 0
    if !($array[longitud][pos_columna])
      if $usuarioX
        $array[longitud][pos_columna] = "Rojo"
        ficha_puesta = true
      else
        $array[longitud][pos_columna] = "Azul"
        ficha_puesta = true
      end
    else
      longitud = longitud - 1
    end
  end

  return ficha_puesta
end

def ingresar_columna()
  puts "Ingrese una columna"
  columna = gets.chomp.to_i
  pos_columna = columna - 1

  if pos_columna >= 0 && pos_columna <= 6
    return pos_columna
  else
    puts "Debe ingresar una columna del 1 al 7"
    ingresar_columna()
  end
end

def mostrarJuego()
  (0..$array.length-1).each do |f|
    print "|"
    (0..$array[f].length-1).each do |c|
      color = $array[f][c] ? $array[f][c] : "----"
      print " " + color + " "
    end
    puts "|"
  end
end

def verGanador(color)
  (0..$array.length-1).each do |f|
    counter = 0
    (0..$array[f].length-1).each do |c|
      if $array[f][c].eql?(color)
        counter = counter + 1
        if counter == 4
          puts "El ganador es el usuario #{color}"
          $juego_terminado = true
          return
        end
      else
        counter = 0
      end
    end
  end

  (0..$array[0].length-1).each do |c|
    counter = 0
    (0..$array.length-1).each do |f|
      if $array[f][c].eql?(color)
        counter = counter + 1
        if counter == 4
          puts "El ganador es el usuario #{color}"
          $juego_terminado = true
          return
        end
      else
        counter = 0
      end
    end
  end
end

while !$juego_terminado
  pos_columna = ingresar_columna()
  ficha_puesta = llenar_columna(pos_columna)
  mostrarJuego()

  if !ficha_puesta
    $columnas_llenas[pos_columna] = true;
    puts "La columna #{pos_columna+1} está llena"
  else
    if $usuarioX
      verGanador("Rojo")
      $usuarioX = false
      $usuarioY = true
    else
      verGanador("Azul")
      $usuarioX = true
      $usuarioY = false
    end
  end

  if !$juego_terminado
    $juego_terminado = $columnas_llenas[0] && $columnas_llenas[1] && $columnas_llenas[2] && $columnas_llenas[3] && $columnas_llenas[4] && $columnas_llenas[5] && $columnas_llenas[6]
  end
end

if $juego_terminado
  puts "El juego se ha terminado"
end
