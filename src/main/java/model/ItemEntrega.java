package model;

public class ItemEntrega {
    private Integer id;
    private Produto produto;
    private int quantidade;

    public ItemEntrega() {}

    public ItemEntrega(Produto produto, int quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Produto getProduto() { return produto; }
    public void setProduto(Produto produto) { this.produto = produto; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
}