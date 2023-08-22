# Define as colunas do arquivo CSV
$header = "ID,Data1,Data2,Data3,Data4"

#Define o Local onde será salvo o arquivo
$File = ”c:\temp\data.csv” 

#Gera o arquivo e coloca o cabeçalho
"$header" | Out-File -FilePath $File -Encoding utf8

# Função para gerar uma data aleatória entre duas datas
function Get-Datas {
    param (
        [DateTime]$startDate,
        [DateTime]$endDate
    )

    if ($endDate -eq $null) {
        throw "O parâmetro 'endDate' não pode ser nulo."
    }

    $daysDifference = ($endDate - $startDate).Days
    $randomDays = Get-Random -Minimum 0 -Maximum $daysDifference

    return $startDate.AddDays($randomDays)
}

# Definir datas mínimas e máximas
$MinDate = Get-Date "01/01/2012"
$MaxDate = Get-Date "31/12/2023"

# Crie um loop que gerará 50 linhas
for ($i = 1; $i -le 50; $i++) {

    # Gerar um número inteiro não repetido para a conta
    $id = $i

    # Gerar as datas
    $data_1 = Get-Datas -startDate $MinDate -endDate $MaxDate
    $data_2 = Get-Datas -startDate $data_1 -endDate $MaxDate
    $data_3 = Get-Datas -startDate $data_2 -endDate $MaxDate
    $data_4 = Get-Datas -startDate $data_3 -endDate $MaxDate

    # Criar uma linha para inserir no CSV
    $linha = "$id,$data_1,$data_2,$data_3,$data_4"

    # Escrever a linha no arquivo CSV
    $linha | Out-File -FilePath $File -Append -Encoding UTF8
}
