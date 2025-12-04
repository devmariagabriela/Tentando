package model;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Entrega {
    
    private static List itens = null;
	private Integer id;
    private String codigo;
    private Integer remetenteId;
    private Integer destinatarioId;
    private Integer enderecoOrigemId;
    private Integer enderecoDestinoId;
    private LocalDate dataColeta;
    private Date dataEntregaPrevista;
    private Date dataEntregaRealizada;
    private String status; // PENDENTE, EM_TRANSITO, REALIZADA, CANCELADA
    private Double valorFrete;
    private String observacoes;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Objetos
    
    private Cliente remetente;
    private Cliente destinatario;
    private Endereco enderecoOrigem;
    private Endereco enderecoDestino;
    private List<ItemEntrega> itens1;
    
    // CONS
    
    
    public Entrega() {
        this.itens1 = new ArrayList<>();
    }
    
    public Entrega(String codigo, Integer remetenteId, Integer destinatarioId,
                   Integer enderecoOrigemId, Integer enderecoDestinoId,
                   LocalDate dataColeta, Date dataEntregaPrevista,
                   Double valorFrete) {
        this();
        this.codigo = codigo;
        this.remetenteId = remetenteId;
        this.destinatarioId = destinatarioId;
        this.enderecoOrigemId = enderecoOrigemId;
        this.enderecoDestinoId = enderecoDestinoId;
        this.dataColeta = dataColeta;
        this.dataEntregaPrevista = dataEntregaPrevista;
        this.valorFrete = valorFrete;
        this.status = "PENDENTE";
    }
    
    // Getters e Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getCodigo() {
        return codigo;
    }
    
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    
    public Integer getRemetenteId() {
        return remetenteId;
    }
    
    public void setRemetenteId(Integer remetenteId) {
        this.remetenteId = remetenteId;
    }
    
    public Integer getDestinatarioId() {
        return destinatarioId;
    }
    
    public void setDestinatarioId(Integer destinatarioId) {
        this.destinatarioId = destinatarioId;
    }
    
    public Integer getEnderecoOrigemId() {
        return enderecoOrigemId;
    }
    
    public void setEnderecoOrigemId(Integer enderecoOrigemId) {
        this.enderecoOrigemId = enderecoOrigemId;
    }
    
    public Integer getEnderecoDestinoId() {
        return enderecoDestinoId;
    }
    
    public void setEnderecoDestinoId(Integer enderecoDestinoId) {
        this.enderecoDestinoId = enderecoDestinoId;
    }
    
    public LocalDate getDataColeta() {
        return dataColeta;
    }
    
    public void setDataColeta(LocalDate dataColeta) {
        this.dataColeta = dataColeta;
    }
    
    public Date getDataEntregaPrevista() {
        return dataEntregaPrevista;
    }
    
    public void setDataEntregaPrevista(Date dataEntregaPrevista) {
        this.dataEntregaPrevista = dataEntregaPrevista;
    }
    
    public Date getDataEntregaRealizada() {
        return dataEntregaRealizada;
    }
    
    public void setDataEntregaRealizada(Date localDate) {
        this.dataEntregaRealizada = localDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Double getValorFrete() {
        return valorFrete;
    }
    
    public void setValorFrete(Double valorFrete) {
        this.valorFrete = valorFrete;
    }
    
    public String getObservacoes() {
        return observacoes;
    }
    
    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Cliente getRemetente() {
        return remetente;
    }
    
    public void setRemetente(Cliente remetente) {
        this.remetente = remetente;
    }
    
    public Cliente getDestinatario() {
        return destinatario;
    }
    
    public void setDestinatario(Cliente destinatario) {
        this.destinatario = destinatario;
    }
    
    public Endereco getEnderecoOrigem() {
        return enderecoOrigem;
    }
    
    public void setEnderecoOrigem(Endereco enderecoOrigem) {
        this.enderecoOrigem = enderecoOrigem;
    }
    
    public Endereco getEnderecoDestino() {
        return enderecoDestino;
    }
    
    public void setEnderecoDestino(Endereco enderecoDestino) {
        this.enderecoDestino = enderecoDestino;
    }
    
    public List<ItemEntrega> getItens() {
        return itens;
    }
    
    public void setItens(List itens) {
        this.itens = itens;
    }
    
    public void addItem(ItemEntrega item) {
        this.itens.add(item);
    }
    
    public boolean isRealizada() {
        return "REALIZADA".equals(status);
    }

    public boolean isPendente() {
        return "PENDENTE".equals(status);
    }
    
    @Override
    public String toString() {
        return "Entrega{" +
                "id=" + id +
                ", codigo='" + codigo + '\'' +
                ", status='" + status + '\'' +
                ", dataColeta=" + dataColeta +
                ", dataEntregaPrevista=" + dataEntregaPrevista +
                ", valorFrete=" + valorFrete +
                '}';
    }
}
