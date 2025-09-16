#!/bin/bash

# =============================
# Configuração
# =============================
BASE_URL="http://mottu-mottion-api.brazilsouth.azurecontainer.io:8080"
export LANG=C.UTF-8

echo "🚀 Testando API - $BASE_URL"
echo "============================================="

# =============================
# Função para requisições
# =============================
make_request() {
    local method="$1"
    local url="$2"
    local data="$3"
    local description="$4"

    echo -e "\n${description}"
    echo "Método: $method"
    echo "URL: $url"
    if [ ! -z "$data" ]; then
        echo "Dados: $data"
    fi
    echo "Resposta:"
    echo "----------------------------------------"

    if [ ! -z "$data" ]; then
        response=$(curl -s -w "\nStatus HTTP: %{http_code}\nTempo: %{time_total}s\n" \
            -X "$method" "$url" \
            -H "Content-Type: application/json; charset=utf-8" \
            -H "Accept: application/json; charset=utf-8" \
            --data-raw "$data")
    else
        response=$(curl -s -w "\nStatus HTTP: %{http_code}\nTempo: %{time_total}s\n" \
            -X "$method" "$url" \
            -H "Accept: application/json; charset=utf-8")
    fi

    # Formata JSON se possível
    if command -v jq > /dev/null 2>&1; then
        echo "$response" | head -n -2 | jq . 2>/dev/null || echo "$response" | head -n -2
    else
        echo "$response" | head -n -2
    fi

    # Exibe status HTTP e tempo
    echo "$response" | tail -n 2
    echo "----------------------------------------"
    
    # Pequena pausa entre requisições
    sleep 0.5
}

# =============================
# TESTES DE CLIENTES - 1 POR ENDPOINT
# =============================
echo -e "\n============================================="
echo "👥 TESTANDO ENDPOINTS DE CLIENTES"
echo "============================================="

# 1. LISTAR TODOS OS CLIENTES
make_request "GET" "$BASE_URL/clientes?pageNumber=1&pageSize=10" "" \
"📋 1. LISTAR CLIENTES"

# 2. BUSCAR CLIENTE POR ID
make_request "GET" "$BASE_URL/clientes/1" "" \
"🔍 2. BUSCAR CLIENTE POR ID"

# 3. CRIAR CLIENTE
make_request "POST" "$BASE_URL/clientes" \
'{
    "nomeCliente": "Jonas Silva Santos",
    "telefoneCliente": "(11) 99999-8888",
    "sexoCliente": "M",
    "emailCliente": "jonas.silva@email.com",
    "cpfCliente": "12345678901"
}' \
"📝 3. CRIAR CLIENTE"

# 4. ATUALIZAR CLIENTE
make_request "PUT" "$BASE_URL/clientes/1" \
'{
    "nomeCliente": "Jonas Silva Santos Junior",
    "telefoneCliente": "(11) 99999-9999",
    "sexoCliente": "M",
    "emailCliente": "jonas.silvajr@email.com",
    "cpfCliente": "12345678901"
}' \
"✏️ 4. ATUALIZAR CLIENTE"

# 5. DELETAR CLIENTE
make_request "DELETE" "$BASE_URL/clientes/1" "" \
"🗑️ 5. DELETAR CLIENTE"

# =============================
# RESUMO DOS TESTES
# =============================
echo -e "\n✅ Todos os testes concluídos!"
echo "============================================="
echo "📊 RESUMO DOS TESTES EXECUTADOS:"
echo "• ✅ GET /clientes (Listar clientes)"
echo "• ✅ GET /clientes/{id} (Buscar por ID)"
echo "• ✅ POST /clientes (Criar cliente)"
echo "• ✅ PUT /clientes/{id} (Atualizar cliente)"
echo "• ✅ DELETE /clientes/{id} (Deletar cliente)"
echo "• 📈 Total: 5 endpoints testados"
echo "============================================="
echo ""
echo "🌐 Documentação disponível em:"
echo "   $BASE_URL/scalar"
echo "============================================="