package model;

import java.time.LocalDateTime;

public class Produto {
    
    private Integer id;
    private String nome;
    private String descricao;
    private Double pesoKg;
    private Double volumeM3;
    private String unidadeVolume; 
    private Double valorUnitario;
    private Integer quantidadeEstoque;
    private LocalDateTime createdAt;
    
    // CONS
    
    public Produto() {
    }
    
    public Produto(String nome, String descricao, Double pesoKg, 
                   Double volumeM3, String unidadeVolume, Double valorUnitario, Integer quantidadeEstoque) {
        this.nome = nome;
        this.descricao = descricao;
        this.pesoKg = pesoKg;
        this.volumeM3 = volumeM3;
        this.unidadeVolume = unidadeVolume; 
        this.valorUnitario = valorUnitario;
        this.quantidadeEstoque = quantidadeEstoque;
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
    
    // NOVO GETTER E SETTER PARA UNIDADE DE VOLUME
    public String getUnidadeVolume() {
        return unidadeVolume;
    }
    
    public void setUnidadeVolume(String unidadeVolume) {
        this.unidadeVolume = unidadeVolume;
    }
    
    public Integer getQuantidadeEstoque() {
        return quantidadeEstoque;
    }

    public void setQuantidadeEstoque(Integer quantidadeEstoque) {
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
    
    
     
    public Double getVolumeEmMetrosCubicos() {
        if (volumeM3 == null || unidadeVolume == null) {
            return volumeM3;
        }
        
        switch (unidadeVolume.toLowerCase()) {
            case "cm3":
            case "ml":
                return volumeM3 / 1000000.0; // 1 m³ = 1.000.000 cm³
            case "dm3":
            case "l":
                return volumeM3 / 1000.0; // 1 m³ = 1.000 dm³
            case "m3":
            default:
                return volumeM3;
        }
    }
    
   
    public String getVolumeFormatado() {
        if (volumeM3 == null || unidadeVolume == null) {
            return "-";
        }
        
        String unidadeExibicao;
        switch (unidadeVolume.toLowerCase()) {
            case "cm3":
                unidadeExibicao = "cm³";
                break;
            case "dm3":
                unidadeExibicao = "dm³";
                break;
            case "m3":
                unidadeExibicao = "m³";
                break;
            case "ml":
                unidadeExibicao = "mL";
                break;
            case "l":
                unidadeExibicao = "L";
                break;
            default:
                unidadeExibicao = unidadeVolume;
        }
        
        return String.format("%.3f %s", volumeM3, unidadeExibicao);
    }
    
    @Override
    public String toString() {
        return "Produto{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", pesoKg=" + pesoKg +
                ", volume=" + getVolumeFormatado() +
                ", valorUnitario=" + valorUnitario +
                ", quantidadeEstoque=" + quantidadeEstoque +
                '}';
    }
}