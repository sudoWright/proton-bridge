// Copyright (c) 2023 Proton AG
//
// This file is part of Proton Mail Bridge.
//
// Proton Mail Bridge is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Proton Mail Bridge is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Proton Mail Bridge. If not, see <https://www.gnu.org/licenses/>.

package knowledgebase

import (
	_ "embed"
	"encoding/json"
)

//go:embed kbArticleList.json
var articleListString []byte

// Article is a struct that holds information about a knowledge-base article.
type Article struct {
	URL      string   `json:"url"`
	Title    string   `json:"title"`
	Keywords []string `json:"keywords"`
}

type ArticleList []Article

// getArticleList returns the list of KB articles.
func getArticleList() (ArticleList, error) {
	var articles ArticleList
	err := json.Unmarshal(articleListString, &articles)

	return articles, err
}

// GetSuggestions return a list of up to 3 suggestions for KB articles matching the given user input.
func GetSuggestions(_ string) (ArticleList, error) {
	// TBD
	return ArticleList{}, nil
}
