# GenExAT : Gene Expression Analysis Tool

Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.

It is a Shiny web application with All Rights Reserved to aforementioned authors.
This repo contains production code of GenExAT and maintained by @[sultanghazala](https://github.com/sultanghazala)

---
### Web Links

- GenExAT Webserver:  Available soon.
- Project Overview : [https://github.com/sultanghazala/GenExAT/]
- Documenation : [https://github.com/sultanghazala/GenExAT/doc]
- GenExAT Tutorial: Available soon.

---
### Developement Details

- R version used: 4.0
- Current Deployment: RShiny (Local Machine)
- Docker Image: Available here soon.

---
### Steps to run at localhost

1. Install R -version 4.0
2. Install R Studio
3. Download the repo and unzip in a folder.
4. Open Global.R in R studio and Install mentioned packages.
5. Click on Run 
6. Explore GenExAT with demo data and learn from tutorial given above.

---
### To run this app in local machine, user need to install following packages.
install.packages(c("reshape2","ggplot2","ggthemes","gplots","ggvis","dplyr","tidyr","DT", "readr",
                   "RColorBrewer","pheatmap","shinyBS","plotly","janitor",
                   "markdown","NMF","scales","heatmaply"))

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("limma","edgeR"))

---
### Developers
Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.

We would appreciate reports of any issues with the tool via the issues option of 
Github (https://github.com/sultanghazala/GenExAT) or email at gsultan@myamu.ac.in

---
### Licensing
This shiny code is licensed under the GPLv3. Please see the file LICENSE.txt for information.
 This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
---    
