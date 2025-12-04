package model;

import java.time.LocalDateTime;
import java.util.List;

public class ItemEntrega {
    
    private Integer id;
    private Integer entregaId;
    private Integer produtoId;
    private Integer quantidade;
    private Double valorTotal;
    private LocalDateTime createdAt;
    
    // OBJETOS
    
    private Produto produto;
    
    // CONS
    
    public ItemEntrega() {
    }
    
    public ItemEntrega(Integer entregaId, Integer produtoId, Integer quantidade,Double valorTotal) {
        this.entregaId = entregaId;
        this.produtoId = produtoId;
        this.quantidade = quantidade;
        this.valorTotal = valorTotal;
    }
    
    // GS
    
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getEntregaId() {
        return entregaId;
    }
    
    public void setEntregaId(Integer entregaId) {
        this.entregaId = entregaId;
    }
    
    public Integer getProdutoId() {
        return produtoId;
    }
    
    public void setProdutoId(Integer produtoId) {
        this.produtoId = produtoId;
    }
    
    public Integer getQuantidade() {
        return quantidade;
    }
    
    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }
    
    public Double getValorTotal() {
        return valorTotal;
    }
    
    public void setValorTotal(Double valorTotal) {
        this.valorTotal = valorTotal;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public Produto getProduto() {
        return produto;
    }
    
    public void setProduto(Produto produto) {
        this.produto = produto;
    }
    
    @Override
    public String toString() {
        return "ItemEntrega{" +
                "id=" + id +
                ", entregaId=" + entregaId +
                ", produtoId=" + produtoId +
                ", quantidade=" + quantidade +
                ", valorTotal=" + valorTotal +
                '}';
    }

	public List listarPorEntrega(Integer id2) {
		// TODO Auto-generated method stub
		return null;
	}
}
