package model;

import java.time.LocalDateTime;

public class Produto {
    
    private Integer id;
    private String nome;
    private String descricao;
    private Double pesoKg;
    private Double volumeM3;
    private Double valorUnitario;
    private Integer quantidadeEstoque; // NOVO CAMPO
    private LocalDateTime createdAt;
    
    // CONS
    
    public Produto() {
    }
    
    public Produto(String nome, String descricao, Double pesoKg, 
                   Double volumeM3, Double valorUnitario, Integer quantidadeEstoque) { // CONSTRUTOR ALTERADO
        this.nome = nome;
        this.descricao = descricao;
        this.pesoKg = pesoKg;
        this.volumeM3 = volumeM3;
        this.valorUnitario = valorUnitario;
        this.quantidadeEstoque = quantidadeEstoque; // NOVO
    }
    
    // GS
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getNome() {
        return nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public String getDescricao() {
        return descricao;
    }
    
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    
    public Double getPesoKg() {
        return pesoKg;
    }
    
    public void setPesoKg(Double pesoKg) {
        this.pesoKg = pesoKg;
    }
    
    public Double getVolumeM3() {
        return volumeM3;
    }
    
    public void setVolumeM3(Double volumeM3) {
        this.volumeM3 = volumeM3;
    }
    
    public Integer getQuantidadeEstoque() { // NOVO GETTER
        return quantidadeEstoque;
    }

    public void setQuantidadeEstoque(Integer quantidadeEstoque) { // NOVO SETTER
        this.quantidadeEstoque = quantidadeEstoque;
    }

    public Double getValorUnitario() {
        return valorUnitario;
    }
    
    public void setValorUnitario(Double valorUnitario) {
        this.valorUnitario = valorUnitario;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Produto{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", pesoKg=" + pesoKg +
                ", volumeM3=" + volumeM3 +
                ", valorUnitario=" + valorUnitario +
                ", quantidadeEstoque=" + quantidadeEstoque + // ALTERADO
                '}';
    }
}