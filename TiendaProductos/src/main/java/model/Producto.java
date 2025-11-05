package model;

public class Producto {

    private String nombre;
    private String categoria;
    private double precio;
    private boolean enOferta;

    public Producto() {
    }

    public Producto(String nombre, String categoria, double precio, boolean enOferta) {
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.enOferta = enOferta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public boolean isEnOferta() {
        return enOferta;
    }

    public void setEnOferta(boolean enOferta) {
        this.enOferta = enOferta;
    }
}
