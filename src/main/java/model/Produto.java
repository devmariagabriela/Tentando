package model;


public class Produto {
    private int id;
    private String nome;
    private double peso;
    private double volume;
    private double valor;


    // CONS
    public Produto() {

    }
    public Produto(int id, String nome, double peso, double volume, double valor) {
        this.id = id;
        this.nome = nome;
        this.peso = peso;
        this.volume = volume;
        this.valor = valor;
    }

    // GS
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

   
    public double getPeso() { return peso; }
    public void setPeso(double peso) { this.peso = peso; }

    public double getVolume() { return volume; }
    public void setVolume(double volume) { this.volume = volume; }

    public double getValor() { return valor; }
    public void setValor(double valor) { this.valor = valor; }

}