package model;

public class Produto {
    private Integer id;
    private String nome;
    private double peso;      // em kg
    private double volume;    // em m³
    private double valor;     // em R$


    //GS

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public double getPeso() { return peso; }
    public void setPeso(double peso) { this.peso = peso; }

    public double getVolume() { return volume; }
    public void setVolume(double volume) { this.volume = volume; }

    public double getValor() { return valor; }
    public void setValor(double valor) { this.valor = valor; }
}