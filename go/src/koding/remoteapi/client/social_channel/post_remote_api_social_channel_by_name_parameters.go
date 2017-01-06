package social_channel

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// NewPostRemoteAPISocialChannelByNameParams creates a new PostRemoteAPISocialChannelByNameParams object
// with the default values initialized.
func NewPostRemoteAPISocialChannelByNameParams() *PostRemoteAPISocialChannelByNameParams {
	var ()
	return &PostRemoteAPISocialChannelByNameParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPISocialChannelByNameParamsWithTimeout creates a new PostRemoteAPISocialChannelByNameParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPISocialChannelByNameParamsWithTimeout(timeout time.Duration) *PostRemoteAPISocialChannelByNameParams {
	var ()
	return &PostRemoteAPISocialChannelByNameParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPISocialChannelByNameParamsWithContext creates a new PostRemoteAPISocialChannelByNameParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPISocialChannelByNameParamsWithContext(ctx context.Context) *PostRemoteAPISocialChannelByNameParams {
	var ()
	return &PostRemoteAPISocialChannelByNameParams{

		Context: ctx,
	}
}

/*PostRemoteAPISocialChannelByNameParams contains all the parameters to send to the API endpoint
for the post remote API social channel by name operation typically these are written to a http.Request
*/
type PostRemoteAPISocialChannelByNameParams struct {

	/*Body
	  body of the request

	*/
	Body models.DefaultSelector

	timeout    time.Duration
	Context    context.Context
	HTTPClient *http.Client
}

// WithTimeout adds the timeout to the post remote API social channel by name params
func (o *PostRemoteAPISocialChannelByNameParams) WithTimeout(timeout time.Duration) *PostRemoteAPISocialChannelByNameParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API social channel by name params
func (o *PostRemoteAPISocialChannelByNameParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API social channel by name params
func (o *PostRemoteAPISocialChannelByNameParams) WithContext(ctx context.Context) *PostRemoteAPISocialChannelByNameParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API social channel by name params
func (o *PostRemoteAPISocialChannelByNameParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithBody adds the body to the post remote API social channel by name params
func (o *PostRemoteAPISocialChannelByNameParams) WithBody(body models.DefaultSelector) *PostRemoteAPISocialChannelByNameParams {
	o.SetBody(body)
	return o
}

// SetBody adds the body to the post remote API social channel by name params
func (o *PostRemoteAPISocialChannelByNameParams) SetBody(body models.DefaultSelector) {
	o.Body = body
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPISocialChannelByNameParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	if err := r.SetBodyParam(o.Body); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}
