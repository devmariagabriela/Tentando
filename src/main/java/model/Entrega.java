package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Entrega {
    private Integer id;
    private String codigoRastreio;
    private LocalDate dataCriacao;
    private LocalDate dataPrevistaEntrega;
    private String status;
    private double valorFrete;
    private String observacoes;
    private Cliente remetente;
    private Cliente destinatario;
    private List<ItemEntrega> itens = new ArrayList<>();

    public Entrega() {
        this.dataCriacao = LocalDate.now();
        this.status = "PENDENTE";
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getCodigoRastreio() { return codigoRastreio; }
    public void setCodigoRastreio(String codigoRastreio) { this.codigoRastreio = codigoRastreio; }

    public LocalDate getDataCriacao() { return dataCriacao; }
    public void setDataCriacao(LocalDate dataCriacao) { this.dataCriacao = dataCriacao; }

    public LocalDate getDataPrevistaEntrega() { return dataPrevistaEntrega; }
    public void setDataPrevistaEntrega(LocalDate dataPrevistaEntrega) { this.dataPrevistaEntrega = dataPrevistaEntrega; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getValorFrete() { return valorFrete; }
    public void setValorFrete(double valorFrete) { this.valorFrete = valorFrete; }

    public String getObservacoes() { return observacoes; }
    public void setObservacoes(String observacoes) { this.observacoes = observacoes; }

    public Cliente getRemetente() { return remetente; }
    public void setRemetente(Cliente remetente) { this.remetente = remetente; }

    public Cliente getDestinatario() { return destinatario; }
    public void setDestinatario(Cliente destinatario) { this.destinatario = destinatario; }

    public List<ItemEntrega> getItens() { return itens; }
    public void setItens(List<ItemEntrega> itens) { this.itens = itens; }

    public void addItem(ItemEntrega item) {
        this.itens.add(item);
    }
}