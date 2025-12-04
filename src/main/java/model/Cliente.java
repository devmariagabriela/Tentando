package model;

import java.time.LocalDateTime;

public class Cliente {
    
    private Integer id;
    private String tipoDocumento; // "CPF" ou "CNPJ"
    private String documento;
    private String nome;
    private String telefone;
    private String email;
    private Integer enderecoId;
    private Endereco endereco; // Objeto relacionado
    private LocalDateTime createdAt;
    
    // CONS
    
    public Cliente() {
    }
    
    public Cliente(String tipoDocumento, String documento, String nome, 
                   String telefone, String email) {
        this.tipoDocumento = tipoDocumento;
        this.documento = documento;
        this.nome = nome;
        this.telefone = telefone;
        this.email = email;
    }
    
    // Getters e Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getTipoDocumento() {
        return tipoDocumento;
    }
    
    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }
    
    public String getDocumento() {
        return documento;
    }
    
    public void setDocumento(String documento) {
        this.documento = documento;
    }
    
    public String getNome() {
        return nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public String getTelefone() {
        return telefone;
    }
    
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public Integer getEnderecoId() {
        return enderecoId;
    }
    
    public void setEnderecoId(Integer enderecoId) {
        this.enderecoId = enderecoId;
    }
    
    public Endereco getEndereco() {
        return endereco;
    }
    
    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public boolean isPessoaFisica() {
        return "CPF".equalsIgnoreCase(tipoDocumento);
    }
    
    public boolean isPessoaJuridica() {
        return "CNPJ".equalsIgnoreCase(tipoDocumento);
    }
    
    @Override
    public String toString() {
        return "Cliente{" +
                "id=" + id +
                ", tipoDocumento='" + tipoDocumento + '\'' +
                ", documento='" + documento + '\'' +
                ", nome='" + nome + '\'' +
                ", telefone='" + telefone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
