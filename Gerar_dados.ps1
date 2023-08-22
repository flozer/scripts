# Define as colunas do arquivo CSV
$header = "ID,Data de Abertura,Data Ativacao,Data Penultima Movimentacao,Data Ultima Movimentacao"

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
$aberturaMinDate = Get-Date "01/01/2012"
$aberturaMaxDate = Get-Date "31/12/2023"

# Crie um loop que gerará 50 linhas (Altere aqui para a quantidade de linhas que você deseja).
for ($i = 1; $i -le 50; $i++) {

    # Gerar um número inteiro não repetido para a o ID
    $id = $i

    # Gerar as datas
    $data_abertura = Get-Datas -startDate $aberturaMinDate -endDate $aberturaMaxDate
    $data_ativacao = Get-Datas -startDate $data_abertura -endDate $aberturaMaxDate
    $data_penultima_movimentacao = Get-Datas -startDate $data_ativacao -endDate $aberturaMaxDate
    $data_ultima_movimentacao = Get-RandomDate -startDate $data_penultima_movimentacao -endDate $aberturaMaxDate

    # Criar uma linha do CSV
    $linha = "$id,$data_abertura,$data_ativacao,$data_penultima_movimentacao,$data_ultima_movimentacao"

    # Escrever a linha no arquivo CSV
    $linha | Out-File -FilePath c:\temp\data.csv -Append -Encoding UTF8
}
