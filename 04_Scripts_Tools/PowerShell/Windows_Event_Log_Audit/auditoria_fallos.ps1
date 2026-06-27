# Definir archivo de salida en el escritorio del usuario "Admin"
$output_file = "C:\Users\Admin\Desktop\auditoria_fallos_Admin.log"

# Crear o limpiar el archivo de salida
$date = Get-Date
"Auditoría de fallos de inicio de sesión para el usuario Admin - $date" | Out-File $output_file -Force
"=============================================" | Out-File $output_file -Append
"" | Out-File $output_file -Append

# Obtener eventos de fallos de inicio de sesión (Event ID 4625) desde el Visor de Eventos
$failures = Get-WinEvent -LogName Security | Where-Object { $_.Id -eq 4625 }

# Filtrar los eventos de fallos de inicio de sesión solo para el usuario "Admin"
$failures_for_admin = $failures | Where-Object {
    $_.Properties[5].Value -eq "Admin"
}

# Procesar los eventos y contar los intentos fallidos para el usuario "Admin"
$failures_for_admin | ForEach-Object {
    $user = $_.Properties[5].Value   # El nombre de usuario está en la propiedad 5
    $user
} | Group-Object | Sort-Object Count | ForEach-Object {
    $user = $_.Name
    $count = $_.Count
    "$user $count" | Out-File $output_file -Append
}

# Mensaje final
"=============================================" | Out-File $output_file -Append
"Fin de la auditoría para el usuario Admin." | Out-File $output_file -Append
