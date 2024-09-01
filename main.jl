abstract type Metrica end

struct Centimetro <: Metrica
    valor::Float64
end

struct Polegada <: Metrica
    valor::Float64
end

function converter(cm::Centimetro, metrica::Type{T}) where T <: Metrica
    conversoes = Dict(Polegada => 1.0 / 2.54)
    valor_convertido = cm.valor * get(conversoes, metrica, 0.0)
    T(valor_convertido)
end

function converter(pol::Polegada, metrica::Type{T}) where T <: Metrica
    conversoes = Dict(Centimetro => 2.54)
    valor_convertido = pol.valor * get(conversoes, metrica, 0.0)
    T(valor_convertido)
end

function to_string(m::Metrica)
    if m isa Centimetro
        return "$(round(m.valor, digits=2)) cm"
    elseif m isa Polegada
        return "$(round(m.valor, digits=2)) pol"
    end
end

function conversao(m::Metrica, metrica::Type{T}) where T <: Metrica
    println(to_string(m))
    println("Convertendo para ", metrica == Polegada ? "polegadas:" : "centímetros:")
    convertido = m isa Centimetro ? converter(m, Polegada) : converter(m, Centimetro)
    println(to_string(convertido))
end


cm = Centimetro(16.0)
conversao(cm, Polegada)

println("\n")

pol = Polegada(9.0)
conversao(pol, Centimetro)
