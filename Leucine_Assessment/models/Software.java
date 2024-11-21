package com.example.useraccessmanagementsystem.models;

public class Software {
    private int softwareId;
    private String name;
    private String description;
    private String accessLevel;

    public Software(String name, String description, String accessLevel) {
        this.name = name;
        this.description = description;
        this.accessLevel = accessLevel;
    }

    public int getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(int softwareId) {
        this.softwareId = softwareId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAccessLevel() {
        return accessLevel;
    }

    public void setAccessLevel(String accessLevel) {
        this.accessLevel = accessLevel;
    }
}
